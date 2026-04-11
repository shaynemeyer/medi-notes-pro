import { NextRequest } from 'next/server';

export async function POST(request: NextRequest) {
  const body = await request.text();
  const auth = request.headers.get('Authorization') ?? '';

  const upstream = await fetch('http://localhost:8001/api/consultation', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: auth,
    },
    body,
  });

  return new Response(upstream.body, {
    status: upstream.status,
    headers: {
      'Content-Type': 'text/event-stream',
      'Cache-Control': 'no-cache',
      Connection: 'keep-alive',
    },
  });
}
