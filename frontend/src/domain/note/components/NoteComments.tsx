import { useState, useEffect } from 'react'
import { Avatar, Button, Input, List, message } from 'antd'
import {
  createComment,
  deleteComment,
  getComments,
} from '@/request/api/comment'
import { NoteComment } from '@/domain/note/types'
import { useUser } from '@/domain/user/hooks/useUser'
import { formatDistanceToNow } from 'date-fns'
import { zhCN } from 'date-fns/locale'

interface NoteCommentsProps {
  noteId: number
}

export function NoteComments({ noteId }: NoteCommentsProps) {
  const [comments, setComments] = useState<NoteComment[]>([])
  const [content, setContent] = useState('')
  const [loading, setLoading] = useState(false)
  const currentUser = useUser()

  // 加载评论列表
  const loadComments = async () => {
    try {
      const resp = await getComments({ noteId })
      if (resp?.data?.data) {
        setComments(resp.data.data)
      }
    } catch (error) {
      message.error('加载评论失败')
    }
  }

  // 提交评论
  const handleSubmit = async () => {
    if (!currentUser?.userId) {
      message.warning('请先登录')
      return
    }

    if (!content.trim()) {
      message.warning('请输入评论内容')
      return
    }

    setLoading(true)
    try {
      await createComment({ noteId, content: content.trim() })
      message.success('评论成功')
      setContent('')
      loadComments()
    } catch (error) {
      message.error('评论失败')
    } finally {
      setLoading(false)
    }
  }

  // 删除评论
  const handleDelete = async (commentId: number) => {
    try {
      await deleteComment(commentId)
      message.success('删除成功')
      loadComments()
    } catch (error) {
      message.error('删除失败')
    }
  }

  useEffect(() => {
    loadComments()
  }, [noteId])

  return (
    <div className="note-comments">
      <div className="comment-input">
        <Input.TextArea
          value={content}
          onChange={(e) => setContent(e.target.value)}
          placeholder="写下你的评论..."
          autoSize={{ minRows: 2, maxRows: 6 }}
          maxLength={500}
          showCount
        />
        <Button
          type="primary"
          onClick={handleSubmit}
          loading={loading}
          style={{ marginTop: 8, float: 'right' }}
        >
          发表评论
        </Button>
      </div>

      <List
        style={{ clear: 'both', marginTop: 16 }}
        itemLayout="horizontal"
        dataSource={comments}
        renderItem={(comment) => (
          <List.Item
            actions={[
              String(comment.userId) === currentUser?.userId && (
                <Button
                  type="link"
                  danger
                  onClick={() => handleDelete(comment.id)}
                >
                  删除
                </Button>
              ),
            ]}
          >
            <List.Item.Meta
              avatar={<Avatar src={currentUser?.avatarUrl} />}
              title={currentUser?.username}
              description={
                <div>
                  <div>{comment.content}</div>
                  <div className="text-sm text-gray-400">
                    {formatDistanceToNow(new Date(comment.createdAt), {
                      addSuffix: true,
                      locale: zhCN,
                    })}
                  </div>
                </div>
              }
            />
          </List.Item>
        )}
      />
    </div>
  )
}
