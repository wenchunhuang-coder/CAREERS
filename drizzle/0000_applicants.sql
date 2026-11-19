CREATE TABLE IF NOT EXISTS jobs (
  id TEXT PRIMARY KEY,
  title_zh TEXT NOT NULL,
  title_en TEXT NOT NULL,
  department TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  location TEXT NOT NULL DEFAULT '林口校區',
  status TEXT NOT NULL DEFAULT 'open' CHECK(status IN ('open','closed')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS applicants (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  mode TEXT NOT NULL CHECK(mode IN ('job','talent')),
  job_id TEXT,
  status TEXT NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','received','processing','hired','rejected','archived')),
  payload TEXT NOT NULL DEFAULT '{}',
  original_payload TEXT,
  attachments TEXT NOT NULL DEFAULT '[]',
  submitted_at TEXT,
  rejected_at TEXT,
  archived_at TEXT,
  posthire TEXT NOT NULL DEFAULT '{}',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY(job_id) REFERENCES jobs(id)
);
CREATE INDEX IF NOT EXISTS applicants_email_idx ON applicants(email);
CREATE INDEX IF NOT EXISTS applicants_status_idx ON applicants(status, updated_at);
CREATE TABLE IF NOT EXISTS otp_codes (
  email TEXT PRIMARY KEY,
  code_hash TEXT NOT NULL,
  expires_at INTEGER NOT NULL,
  attempts INTEGER NOT NULL DEFAULT 0,
  sent_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS audit_log (
  id TEXT PRIMARY KEY,
  actor TEXT NOT NULL,
  action TEXT NOT NULL,
  applicant_id TEXT,
  details TEXT NOT NULL DEFAULT '{}',
  created_at TEXT NOT NULL
);
