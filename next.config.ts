import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  output: 'standalone',
  async rewrites() {
    return [
      {
        source: '/health',
        destination: 'http://localhost:8001/health',
      },
    ];
  },
};

export default nextConfig;
