---
name: "WhatsApp Broadcast"
platform: "whatsapp"
content_type: "broadcast"
description: "Broadcast messages optimized for open rates, replies, and conversational engagement"
constraints:
  message_max_chars: 4096
  optimal_message_length: "300-500 chars"
  broadcast_list_max: 256
version: "1.0.0"
---

## Platform Rules

- Messages delivered as individual chats (1-to-1 dynamic).
- Recipients must have your number saved.
- Open rates average 90-98%.
- Limit to 2-4 messages per week maximum.

## Content Structure

1. **Greeting** — Personalized with {{name}}.
2. **Value hook** — What this message delivers.
3. **Body** — 2-4 short paragraphs, one idea each.
4. **CTA** — Single, clear action.
5. **Signature** — Sign-off with sender name.

## Writing Guidelines

- Write like texting a friend.
- Keep under 500 characters.
- 1-3 emojis for warmth.
- One message, one purpose.
- Include opt-out option.

## Quality Criteria

- [ ] Personalized greeting with {{name}}
- [ ] Under 500 characters
- [ ] Clear value hook in first two lines
- [ ] Single purpose per message
- [ ] Single CTA
- [ ] Opt-out instruction included
- [ ] Conversational tone
