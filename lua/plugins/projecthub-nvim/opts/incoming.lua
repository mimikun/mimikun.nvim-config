-- Incoming commits.
-- The history always shows your local repository;
-- when upstream has newer commits a background `git fetch` picks them up and the inspector lists them above a divider, separated from the point you are synced at.
-- The fetch only updates remote refs: HEAD, the index and the working tree are never touched.
local incoming = {
  -- false to never reach out to the network
  enabled = true,

  -- Seconds between two fetches of the same repo (minimum 60)
  interval = 300,

  -- Seconds after which a stuck fetch is abandoned
  timeout = 15,

  -- Announce when new commits show up
  notify = true,

  -- Above this many contributors: followed silently,
  notify_max_authors = 5,

  -- and from further away.
  -- `b` overrides per project.
}

return incoming
