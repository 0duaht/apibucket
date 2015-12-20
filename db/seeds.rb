User.destroy_all
Bucketlist.destroy_all
Item.destroy_all

3.times do |n|
  user = User.create(
    name: "User#{n + 1}",
    email: "user#{n + 1}@seed.com",
    password: "user#{n + 1}pass"
  )

  3.times do |i|
    bucketlist = Bucketlist.create(
      name: "Bucketlist #{i + 1}",
      user_id: user.id
    )

    10.times do |j|
      Item.create(
        name: "Item #{j + 1}",
        bucketlist_id: bucketlist.id
      )
    end
  end
end
