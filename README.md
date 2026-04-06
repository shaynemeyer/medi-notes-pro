# Business Idea Generator

AI-powered SaaS app that streams creative business ideas for AI Agents in real-time.

## Stack

- **Frontend:** Next.js 16, React 19, TypeScript, TailwindCSS 4
- **Backend:** FastAPI (Python), Server-Sent Events (SSE)
- **AI:** OpenAI API (streamed responses)

## Getting Started

### Prerequisites

- Node.js
- Python (with `uv`)
- OpenAI API key

### Environment

Create a `.env` file in the project root:

```
OPENAI_API_KEY=your_key_here
```

### Run the frontend

```bash
npm run dev
```

### Run the backend

```bash
uv run uvicorn api.index:app --reload
```

Open [http://localhost:3000](http://localhost:3000) to view the app.

## Deployment

Configured for [Vercel](https://vercel.com). Set `OPENAI_API_KEY` in your Vercel project environment variables.
