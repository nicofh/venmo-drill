json.title       payment.title
json.id          payment.id
json.amount      payment.amount
json.description payment.description
json.date        payment.created_at

json.sender do
  json.partial! 'api/v1/users/info', user: payment.sender.user
end
json.receiver do
  json.partial! 'api/v1/users/info', user: payment.receiver.user
end
