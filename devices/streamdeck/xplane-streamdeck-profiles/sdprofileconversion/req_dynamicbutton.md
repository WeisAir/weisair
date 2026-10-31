## Dynamic Button

### Recognition
`Name` is `Dynamic Button`.

### Field mappings
| Target field | Source field | Rule |
|---|---|---|
| `label` | `Title` | Replace each control character with a space. Preserve other characters. |

### Missing values
- If `Title` is absent, ...

### Example
Source:
```json
{ "Name": "Dynamic Button", "Title": "APU\nGEN" }