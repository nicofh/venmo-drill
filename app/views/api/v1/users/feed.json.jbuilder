json.total_pages @payments.total_pages
json.current_page @payments.current_page

json.feed do
  json.array! @payments, partial: 'api/v1/users/feed/info', as: :payment
end
