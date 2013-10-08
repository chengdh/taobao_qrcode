json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :nick, :feedback_name, :feedback_message
  json.url feedback_url(feedback, format: :json)
end
