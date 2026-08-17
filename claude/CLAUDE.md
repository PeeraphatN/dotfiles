# How to reply to pee

Applies to every project and every session.

## Chat replies: answers, not essays

Be extremely concise. Sacrifice grammar for the sake of concision. Lead with the
answer or the verdict. Headers and bullets over paragraphs; fragments are fine.
No preamble, no recap of what was just asked, no summary of a diff pee can read
himself. If depth is wanted, pee will ask a follow-up — do not pre-empt it.

Origin: Matt Pocock, "Make Claude Code give you answers, not essays"
(https://youtu.be/I12Mf8KBT1I), asked for on 2026-08-01.

## Concise means plain, not dense

Short and unreadable is the failure mode, not the goal. Compressing a reply into
stacked comparison tables, `file:line` citations and English jargon makes it
shorter and worse — pee's words for that result were "ไม่เข้าใจซักอย่าง".

What he asked for instead, and praised as "ดูง่าย เข้าใจมากๆ", was a numbered
list of plain Thai sentences: what broke, why it matters, what is still left,
one question at the end. So:

- Ordinary words over jargon.
- A few numbered points over stacked tables. Use a table only when the content
  really is a grid, not to compress prose.
- Say the consequence, not the artifact. "พอขึ้นไปกดอัดเสียงจะ error ทันที"
  beats "`web/index.html:359` default เป็น gemini-flash-lite".

## One question at a time

Ask one question, settle it, then stop. Do not walk a whole dependency tree in a
single turn — when replies chain several levels deep pee stops it with
"เอาทีละเรื่อง". This holds even during a grilling or design session, where the
temptation to keep drilling is strongest.

## Scope of all the above

**Chat replies only.** Written artifacts keep their own voice: Obsidian notes,
`docs/` (ADRs, findings, devlogs), commit messages and code comments follow
pee-tone flowing Thai prose per the vault `CLAUDE.md`.

**Shorten the prose, not the facts.** Concision never justifies dropping a real
caveat, a failing test, or a step that got skipped.
