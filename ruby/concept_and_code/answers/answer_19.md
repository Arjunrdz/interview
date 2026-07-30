
MongoDB (the database) does not enforce a schema by default.
Mongoose (the ODM/library) does enforce a schema at the application level.

These are two different layers.

Case 1: Directly in MongoDB

Suppose your Mongoose schema is:

const userSchema = new mongoose.Schema({
  name: String,
  email: String
});


If you bypass Mongoose and use the MongoDB shell (or another client), you can insert:

{
  "name": "Alice",
  "email": "alice@example.com",
  "favoriteColor": "Blue"
}


MongoDB will happily store it.

The document in the database becomes:

{
  "_id": "...",
  "name": "Alice",
  "email": "alice@example.com",
  "favoriteColor": "Blue"
}


The database itself doesn't object.

Case 2: Through Mongoose

If you do:

const user = new User({
  name: "Alice",
  email: "alice@example.com",
  favoriteColor: "Blue"
});

await user.save();


By default, Mongoose has strict: true.

That means favoriteColor is ignored, because it's not in the schema.

The saved document will be:

{
  "name": "Alice",
  "email": "alice@example.com"
}


No favoriteColor.

Case 3: Disable strict mode

You can configure Mongoose like this:

const userSchema = new mongoose.Schema(
  {
    name: String,
    email: String
  },
  {
    strict: false
  }
);


Now:

new User({
  name: "Alice",
  email: "alice@example.com",
  favoriteColor: "Blue"
});


will save:

{
  "name": "Alice",
  "email": "alice@example.com",
  "favoriteColor": "Blue"
}

This is the key idea

People often say "MongoDB is schema-less," but that's not entirely accurate.

A better way to think about it is:

MongoDB: The database doesn't require every document to follow the same structure.
Mongoose: Your application can choose to enforce a schema if you want consistency.

That's why two documents in the same MongoDB collection can legitimately look like this:

{ "name": "Alice", "email": "alice@example.com" }

{ "name": "Bob", "favoriteColor": "Blue" }

{ "name": "Charlie", "age": 25, "city": "Delhi" }


Even if your Mongoose schema doesn't include those fields—provided those documents were inserted outside Mongoose or Mongoose wasn't configured to enforce the schema.

So the flexibility belongs to MongoDB itself, while Mongoose is an optional layer that can make MongoDB behave more like a relational database if that's what your application needs.
