### Filter API
`and -> [ { $col_name: { $operation: $value } } ]`

`or -> [ { $col_name: { $operation: $value } } ]`

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
`order -> [{$col_name: 'asc' | 'desc'}]`

#### Page
page -> number

#### Page Size
page_size -> number