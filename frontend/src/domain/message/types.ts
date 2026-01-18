import { QuestionSummary } from '@/domain/question'

enum MessageType {
  LIKE = 1,
  COMMENT = 2,
  SYSTEM = 3,
}

enum TargetType {
  NOTE = 1,
  COMMENT = 2,
}

export interface MessageQueryParams {
  page?: number
  pageSize?: number
  isRead?: boolean
}

export interface Message {
  messageId: number
  sender: {
    // 发送者信息
    userId: string
    username: string
    avatar: string
  }
  type: MessageType
  // 如果是评论 / 点赞消息的话，通过 target 能够导航到对应的界面
  // 如果是系统消息，target 为空
  target?: {
    type: TargetType
    targetId: number
    question: QuestionSummary
  }
  isRead: boolean
  content: string
  createdAt: string
}
