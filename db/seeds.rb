User.destroy_all
Bucketlist.destroy_all
Item.destroy_all

3.times do |n|
  User.create(
    name: "User#{n + 1}",
    email: "user#{n + 1}@seed.com",
    password: "user#{n + 1}pass"
  )
end

9.times do |n|
  Bucketlist.create(
    name: "Bucketlist #{n + 1}",
    user_id: (n % 3) + 1
  )
end

100.times do |n|
  Item.create(
    name: "Item #{n + 1}",
    bucketlist_id: (n % 10) + 1
  )
end
