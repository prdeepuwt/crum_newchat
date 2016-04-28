json.extract! @message, :id, :body, :user_id, :conversation_id, :created_at, :updated_at
json.conversation_name @message.conversation.name
json.conversation_kind @message.conversation.kind
json.sender_user_id current_user.id
json.sender_user_name current_user.name
json.link conversation_url(@message.conversation)
json.message render('messages/message.html.erb', message: @message)
json.body @message.body
