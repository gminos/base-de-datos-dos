use task;

db.users.insertOne({
  name: null,
  email: null,
  register_date: null
});

db.tasks.insertOne({
  title: null,
  summary: null,
  status: null,
  created_date: null,
  limit_date: null
});
