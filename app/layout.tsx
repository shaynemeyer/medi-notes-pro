import type { Metadata } from 'next';

import { ClerkProvider } from '@clerk/nextjs';
import 'react-datepicker/dist/react-datepicker.css';
import './globals.css';

export const metadata: Metadata = {
  title: 'Healthcare Consultation Assistant',
  description: 'AI-powered medical consultation summaries',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="min-h-full flex flex-col">
        <ClerkProvider>{children}</ClerkProvider>
      </body>
    </html>
  );
}
