### Database

We basically need to create a UI for active records. Users will be creating tables and adding columns, indexes and model level attributes (field resolvers) along with database validations. We need to dynamically craete the following active record classes (Meta-Programming :D): 

- Schema
- Migrations
- Models

lets call this DynamicRecords

### Operations
We'll provide a basic list of operations of every resource in db

#### List
#### Aggregate
#### Get
#### Create
#### Update
#### Delete

### Filter API
```javascript
{ and: [ { $col_name: { $operation: $value } } ] }

{ or: [ { $col_name: { $operation: $value } } ] }
```

example:
```javascript
filter: {
  and: [
    { name: { equals: 'John' } },
    { age: { greater_than: 18 } }
  ],
}

filter: {
  or: [
    { gender: { is_null: true } },
    { age: { between: [ 18, 35 ] } }
  ],
}
```

#### Operations:
- contains
- equals
- not_equals
- is_null
- is_not_null
- starts_with
- ends_with
- in
- between
- greater_than
- greater_than_or_equal
- less_than
- less_than_or_equal

### Order API
```javascript
{ order: [ { $col_name: 'asc' | 'desc' } ] }
```

#### Page
```javascript
page -> number
```

#### Page Size
```javascript
page_size -> number
```