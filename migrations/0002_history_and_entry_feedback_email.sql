ALTER TABLE entries ADD COLUMN feedback_email TEXT NOT NULL DEFAULT '';

CREATE TABLE IF NOT EXISTS submission_reviews_next (
  id TEXT PRIMARY KEY,
  submission_id TEXT NOT NULL DEFAULT '',
  action TEXT NOT NULL CHECK (action IN (
    'submission_created',
    'submission_updated',
    'approved',
    'rejected',
    'entry_created',
    'entry_updated',
    'entry_deleted',
    'entry_rejected',
    'entries_imported'
  )),
  entry_id TEXT NOT NULL DEFAULT '',
  title TEXT NOT NULL DEFAULT '',
  author TEXT NOT NULL DEFAULT '',
  content_tags TEXT NOT NULL DEFAULT '[]',
  flavor_tags TEXT NOT NULL DEFAULT '[]',
  summary TEXT NOT NULL DEFAULT '',
  cover_path TEXT NOT NULL DEFAULT '',
  target_url TEXT NOT NULL DEFAULT '',
  feedback_email TEXT NOT NULL DEFAULT '',
  review_note TEXT NOT NULL DEFAULT '',
  notification TEXT,
  submitted_at TEXT NOT NULL DEFAULT '',
  reviewed_at TEXT NOT NULL
);

INSERT INTO submission_reviews_next
  (id, submission_id, action, entry_id, title, author, content_tags, flavor_tags,
   summary, cover_path, target_url, feedback_email, review_note, notification,
   submitted_at, reviewed_at)
SELECT
  id, submission_id, action, entry_id, title, author, content_tags, flavor_tags,
  summary, cover_path, target_url, feedback_email, review_note, notification,
  submitted_at, reviewed_at
FROM submission_reviews;

DROP TABLE submission_reviews;
ALTER TABLE submission_reviews_next RENAME TO submission_reviews;

CREATE INDEX IF NOT EXISTS idx_submission_reviews_reviewed_at
  ON submission_reviews(reviewed_at DESC);
