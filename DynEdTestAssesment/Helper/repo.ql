{ user(login: "#") { login name email avatarUrl repositories(first: 30) { nodes { ... on Repository { id name pushedAt  updatedAt owner { login } languages(first: 2) { edges { node { color name } } } } } } } }
