---
name: tidy-qwiklabs-challenge-sql
description: >-
  Tidies Qwiklabs / JuaraGCP challenge-lab SQL write-ups with whitespace-only
  cleanup while keeping every original word and SQL verbatim. Use when the user
  asks to tidy, clean up, organize, or add a Challenge Lab .sql file to
  gcp-qwiklabs (or juara-gcp legacy), or when preparing raw lab SQL notes for
  the repo.
---

# Tidy Qwiklabs Challenge Lab SQL

## Goal

Make a messy challenge-lab `.sql` readable for the repo **without changing meaning**.
Priority is documenting the task questions and the author's approach as already written.

## Hard rules (verbatim)

- Keep **every** existing word and SQL as-is: lab prompts, comments, commented experiments, uncommented answers.
- Do **not** condense, paraphrase, or rewrite lab prompts.
- Do **not** add AI-written sections such as Approach / Answer labels, explanations, or summaries.
- Do **not** delete commented thinking SQL; uncommented blocks are the answers.
- Keep lab project IDs (e.g. `qwiklabs-gcp-…`) unchanged (historical fidelity).

## Allowed tidy only

- Collapse runs of excess blank lines to a consistent gap (prefer one blank line between blocks; optional two before a `TASK` header).
- Keep existing section order (scenario → Task 1…N).
- End file with a single trailing newline; strip trailing empty lines at EOF.
- Pure separator comment lines (`-- ---…`) only if they add **zero** prose and the user asked for stronger structure.

## Repo layout

```text
gcp-qwiklabs/
└── <Course or Lab Name>/
    └── <Course or Lab Name>: Challenge Lab.sql
```

- Mirror existing top-level folder naming (e.g. `Build a Data Warehouse with BigQuery`).
- Prefer `.sql` for these write-ups when the user chooses SQL.
- Leave existing polished `.md` challenge labs untouched unless the user asks to change them.
- Do **not** force SQL content to look like the prettier Markdown answers; documentation of questions + approach beats polish.

## Workflow

1. Read the source `.sql` fully.
2. Produce tidied output with **whitespace-only** changes.
3. Verify verbatim preservation (non-empty lines must match exactly after stripping blank-only lines), e.g.:

```python
from pathlib import Path

def nonempty(path):
    return [ln.rstrip() for ln in Path(path).read_text().splitlines() if ln.strip()]

assert nonempty("before.sql") == nonempty("after.sql")
```

4. Place under the correct course folder in this repo.
5. Stop for user review before commit/push unless they explicitly ask to commit/push.

## Anti-patterns

- Condensing the lab prompt into a shorter “requirements” blurb
- Adding “Approach:” / “Answer:” / generative commentary
- Converting to Markdown “to match” older files when the user wants `.sql`
- “Improving” or reformatting SQL tokens beyond blank-line cleanup
