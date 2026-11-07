---
name: evaluate-stocks
description: Research a public company as a potential stock investment using Philip Fisher's complete checklist, business economics, ownership, growth opportunities, and risks. Use for a company or ticker evaluation, not for a live trade order.
---

# Evaluate Stocks

Build a sourced, current company evaluation, saved as an Org file at `~/org/stock-analysis/<ticker>-<MM-yyyy>.org. Fisher's *Common Stocks and Uncommon Profits* calls its checklist **15 points**. Cover all 15 unless the user explicitly asks to omit a point. Paraphrase the questions rather than reproducing the book's wording.

## Research workflow

2. Trace how the company earns money from what it owns or controls to who pays it. Use filings' business, property, segment, geographic, product, contract, and major-customer disclosures; then check customer and competitor filings. Identify the assets or capabilities, customer groups and material named customers, sales channels, contract or purchase process, pricing basis, and what causes revenue to recur or stop. Where customers are unnamed or sales are indirect, describe the customer types and route to market; do not invent names or allocate undisclosed revenue. Check whether announced deals are signed, material, recurring, or merely pilots.
2. Show the source and date for every material figure and conclusion, linking directly to the relevant filing or page. Separate reported facts, management forecasts, third-party estimates, and your own inference. Label missing or stale evidence explicitly; do not turn an absence of evidence into a favorable score. Use a consistent confidence label for each Fisher point: **supported**, **mixed**, or **insufficient evidence**, with a short reason.

## Required report

**Overview** section
Start with a concise description of what the company does and a compact facts line or table for price, market cap, share-count basis, and insider ownership, each dated and sourced. Skip ticker disambiguation, vendor reconciliation, and other scope commentary in the report unless they affect the conclusion.

**How they Make Money** section
Explain **how the company makes money** in operational terms: what it owns or supplies; who the end customers and paying counterparties are; how it reaches and sells to them; what they buy; how prices, contracts, usage, or transactions turn that into revenue; and what drives repeat purchases. Name material customers when publicly confirmed, distinguish them from broad customer groups, and explain concentration where known. Provide a breakdown of what portion of revenue comes from which customers and which business lines. State what customer, pricing, or channel economics the company does not disclose. Include a breakdown of what percentage of revenue comes from which business lines.

Add a **Competitors and Differentiation** section. Name the closest relevant competitors and substitutes by customer group or business line, and explain where they overlap. Compare what each offers, its assets or capabilities, route to customers, and the factors customers use to choose among them: price, quality, reliability, switching effort, reach, or contract terms as relevant. Explain where this company wins and where competitors are stronger, with evidence from filings, customer behavior, market share, contract wins, or other direct sources. Do not treat a difference in size or product mix alone as proof of superiority.

Add a **Moat and Durability** section. Identify any specific mechanism that could protect profits against those competitors, such as cost advantage, switching costs, network effects, scarce assets, trusted brand, distribution, or regulatory position—but only if the evidence supports it. Show how the mechanism affects customer choice or economics, whether competitors can copy or bypass it, how long it may last, and what evidence would disprove it. Distinguish an attractive market, a temporary lead, and a signed contract from a durable moat. Say plainly when the moat is unproven.

Under `* Fisher's 15 points`, assess every point in its own `**` Org subheading from the template, with the conclusion, concrete evidence, confidence label, and at least one direct source per point when evidence exists. Do not collapse the assessments into a single table:

1. Addressable market and room for sustained sales growth.
2. Management's commitment to developing new products or markets after today's offerings mature.
3. Research and development effectiveness relative to spending and company size.
4. Sales and distribution effectiveness compared with peers.
5. Current profit margins and their quality.
6. Credible actions to protect or improve margins.
7. Employee relations and retention. Outline if the company has the ability to hire and retain the best talent.
8. Executive relations and management team stability.
9. Depth of management beyond a few key people.
10. Cost controls, accounting quality, and transparency of unit economics.
11. Industry-specific advantages that matter against competitors; connect this assessment to the moat and competitor sections.
12. Willingness to invest for durable profits rather than maximize the next quarter.
13. Likelihood that future financing will dilute existing shareholders materially.
14. Management's candor with shareholders when results disappoint.
15. Management integrity and alignment with shareholders.

For points 3, 5, 6, 10, and 13, examine several years of revenue, margins, cash flow, R&D, capital expenditure, share count, and debt as applicable; normalize one-off effects and use peers where comparison adds meaning. Present only the figures needed to support a specific conclusion, within that point or a relevant risk. Avoid a standalone multi-year accounting table unless the user asks for one. For points 7–9 and 14–15, look for leadership turnover, compensation and governance disclosures, related-party transactions, capital allocation, restatements, guidance history, and documented employee evidence. Do not present an unverifiable judgment about character as fact. When evaluating management, look to transcripts of interviews to assess their integrity. Look for specific failures and how they addressed them.

Then document **future growth areas**. For each, identify the product or market, why demand could grow, the company's route to capture it, present evidence of traction, timing and potential economic importance if supportable, and what would invalidate the thesis. Distinguish existing revenue from optionality. Identify **potential tailwinds** such as industry demand, regulation, technology adoption, or pricing, and explain the evidence, likely duration, and path from the tailwind to company revenue or profit; do not assume a favorable industry trend benefits this company automatically. Document **risks** with the mechanism of harm, business/financial exposure, observable warning indicators, and any mitigating evidence. Include competition, customer concentration, execution, regulation, capital needs, cyclicality, and valuation where material; omit irrelevant categories rather than filling a template mechanically.

Analyze **upside qualitatively**: what could go better than the market appears to expect, which customer or industry developments could make that happen, what evidence already exists, what milestones would confirm it, and what could prevent the company from capturing the benefit. Connect those mechanisms to the growth areas and tailwinds. Do not build EV/EBITDA scenarios, price targets, or accounting-style valuation tables unless the user explicitly asks.

Close with a balanced synthesis: strongest evidence, biggest unknowns, what to verify next, and the conditions under which the investment case would change. Do not imply the qualitative checklist alone establishes a fair price.

## Save the report

### Formatting Rules

- avoid any lines in org tables longer than 80 characters

Save each completed evaluation as an Org file at `~/org/stock-analysis/<ticker>-<MM-yyyy>.org`, using the evaluated ticker and the report's month and year (for example, `AAPL-11-2026.org`). Create the `stock-analysis` directory if needed. Use Org headings, tables, and `[[URL][source]]` links so the report remains readable in Emacs. If that month's file already exists, read it before updating and preserve unrelated notes; do not silently replace existing work.

Begin the file using a template created by this command: `emacsclient -e '(+agent-lisp-expand-fisher-stock-template "~/org/stock-analysis/FILENAME.org")'`. This inserts `* Fisher's 15 points` and 15 `**` subheadings; fill in every point. Add the business, ownership, competitors, moat, growth, tailwinds, risks, qualitative upside, and synthesis sections around the template. Then run `emacsclient -e '(+format-org "~/org/stock-analysis/file.org")'`.
