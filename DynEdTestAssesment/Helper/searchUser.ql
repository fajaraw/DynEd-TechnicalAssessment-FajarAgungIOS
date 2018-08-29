query { search(type: USER, first: 10, query: "#") { nodes { ... on User { login name email avatarUrl(size:80) } } } }
