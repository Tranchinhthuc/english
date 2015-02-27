User.create!(name:  "Tran Thuc",
  email: "thuctc91@gmail.com",
  address: "Soc Son - Hanoi",
  date_of_join: "Fri, 19 Sep 2014",
  password: "123456",
  password_confirmation: "1234567",
  is_supervisor: true)
Course.create!(name: "Toan 12",
  description: "Luong giac + Ham so + So phuc..."
  )
CourseUser.create!(user_id: 1,
  course_id: 1)