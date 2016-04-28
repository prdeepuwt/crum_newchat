json.extract! @message, :id, :body, :user_id, :conversation_id, :created_at, :updated_at
json.conversation_name @message.conversation.name
json.message render('messages/message.html.erb', message: @message)
