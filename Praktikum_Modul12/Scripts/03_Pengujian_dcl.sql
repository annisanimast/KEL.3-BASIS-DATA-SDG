// GRANT
db.grantPrivilegesToRole("reportRole", [
  {
    resource: {
      db: "transport_db",
      collection: "trips"
    },
    actions: ["find"]
  }
])

// SHOW
db.getRole("reportRole". { showPrivileges: true })

// REVOKE
db.revokePrivilegesFromRole("reportRole", [
  {
    resour: {
      db: "transport_db",
      collection: "trips"
    },
    actions: ["find"]
  }
])

// SHOW
db.getRole("reportRole". { showPrivileges: true })
