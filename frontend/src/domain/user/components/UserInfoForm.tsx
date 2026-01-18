import React, { useEffect, useState } from 'react'
import { useUser } from '../hooks/useUser.ts'
import {
  Avatar,
  Button,
  DatePicker,
  Form,
  GetProp,
  Input,
  message,
  Select,
  UploadFile,
  UploadProps,
} from 'antd'
import { UserState } from '../types/types.ts'
import { useUserForm } from '../hooks/useUserForm.ts'
import dayjs from 'dayjs'
import { Upload } from 'antd'
import ImgCrop from 'antd-img-crop'
import { UploadChangeParam } from 'antd/es/upload/interface'

const UserInfoForm: React.FC = () => {
  /**
   * 用户信息展示
   */
  const user = useUser() as UserState

  const [form] = Form.useForm()
  const [editing, setEditing] = useState(false)

  const { updateUserInfo, updateUserAvatar } = useUserForm()

  const handleEditToggle = () => {
    setEditing(!editing)
  }

  useEffect(() => {
    form.setFieldsValue({
      username: user.username,
      gender: user.gender,
      birthday: dayjs(user.birthday),
      email: user.email,
      school: user.school,
      signature: user.signature,
    })
  })

  const handleSave = async (values: UserState) => {
    const oldValues = user
    // 提取差异字段
    const diff: Partial<typeof oldValues> = {}

    // 这段确实需要特殊处理 birthday 字段
    Object.entries(values).forEach(([key, newValue]) => {
      // @ts-expect-error ...
      const oldValue = oldValues[key]
      if (key === 'birthday') {
        // 类型检查并格式化生日
        const newBirthday = newValue
          ? dayjs(newValue as string | Date).format('YYYY-MM-DD')
          : null
        const oldBirthday =
          dayjs(oldValues[key] as string | Date).format('YYYY-MM-DD') ?? null
        if (newBirthday !== oldBirthday) {
          // @ts-expect-error ...
          diff[key] = newBirthday
        }
      } else if (newValue !== oldValue) {
        // @ts-expect-error ...
        diff[key] = newValue
      }
    })

    // 如果没有修改任何字段，提示用户无需更新
    if (Object.keys(diff).length === 0) {
      message.info('未更新任何字段')
      return
    }

    try {
      await updateUserInfo(diff)
      message.success('更新成功！')
    } catch (e: any) {
      message.error(e.message)
    } finally {
      setEditing(false)
    }
  }

  type FileType = Parameters<GetProp<UploadProps, 'beforeUpload'>>[0]

  const onPreview = async (file: UploadFile) => {
    let src = file.url as string
    if (!src) {
      src = await new Promise((resolve) => {
        const reader = new FileReader()
        reader.readAsDataURL(file.originFileObj as FileType)
        reader.onload = () => resolve(reader.result as string)
      })
    }
    const image = new Image()
    image.src = src
    const imgWindow = window.open(src)
    imgWindow?.document.write(image.outerHTML)
  }

  const uploadAvatarHandle = async (info: UploadChangeParam) => {
    if (info.file.response?.code === 200) {
      // 上传头像成功
      await updateUserAvatar(info.file.response.data.url)
    }
  }

  return (
    <div className="rounded-lg bg-white p-6">
      <div className="mb-6 flex items-center space-x-4">
        <ImgCrop rotationSlider>
          <Upload
            action={() => {
              return (import.meta.env.VITE_API_BASE_URL || '') + '/api/users/avatar'
            }}
            onChange={uploadAvatarHandle}
            onPreview={onPreview}
            accept={'image/*'}
            showUploadList={false}
          >
            <Avatar src={user.avatarUrl} size={64} className="cursor-pointer" />
          </Upload>
        </ImgCrop>
        <div>
          <h2 className="text-2xl font-semibold">{user.username}</h2>
          <p className="text-gray-600">{user.email}</p>
        </div>
        <Button onClick={handleEditToggle} className="ml-auto">
          {editing ? '取消编辑' : '编辑'}
        </Button>
      </div>
      <Form
        form={form}
        layout="vertical"
        onFinish={handleSave}
        className={editing ? '' : 'pointer-events-none'}
      >
        <Form.Item
          label="用户名"
          name="username"
          rules={[{ required: true, message: '请输入用户名' }]}
        >
          <Input disabled={!editing} />
        </Form.Item>
        <Form.Item label="性别" name="gender">
          <Select disabled={!editing}>
            <Select.Option value={1}>男</Select.Option>
            <Select.Option value={2}>女</Select.Option>
            <Select.Option value={3}>保密</Select.Option>
          </Select>
        </Form.Item>
        <Form.Item label="生日" name="birthday">
          <DatePicker disabled={!editing} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          label="邮箱"
          name="email"
          rules={[{ type: 'email', message: '请输入有效的邮箱地址' }]}
        >
          <Input disabled={!editing} />
        </Form.Item>
        <Form.Item label="学校" name="school">
          <Input disabled={!editing} />
        </Form.Item>
        <Form.Item label="个性签名" name="signature">
          <Input.TextArea rows={3} disabled={!editing} />
        </Form.Item>
        {editing && (
          <Form.Item>
            <Button type="primary" htmlType="submit" className="mr-2">
              保存
            </Button>
            <Button onClick={handleEditToggle}>取消</Button>
          </Form.Item>
        )}
      </Form>
    </div>
  )
}

export default UserInfoForm
