### Authentication on Frontend

sample request
```bash
curl --location --request POST 'http://localhost:3000/graphql' \
--header 'access-token: MH_vSll7LQOVEttf7x5ekw' \
--header 'client: 0EM1DWfcflqiJszRRaHFrQ' \
--header 'uid: danish@introspec.app' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query {\n    testField\n}","variables":{}}'
```