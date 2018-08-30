query { search(type: USER, first: 10, query: "#") { nodes { ... on User { login name email followers { totalCount } following{ totalCount } avatarUrl(size:80) } } } }
