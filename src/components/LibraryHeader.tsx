
import React from 'react';
import { cn } from '@/lib/utils';

interface LibraryHeaderProps {
  className?: string;
}

const LibraryHeader: React.FC<LibraryHeaderProps> = ({ className }) => {
  return (
    <header className={cn('text-center py-6', className)}>
      <h1 className="text-3xl font-bold tracking-tight">
        Hệ thống
      </h1>
      <h1 className="text-3xl font-bold tracking-tight mb-8">
        Quản lý thư viện
      </h1>
    </header>
  );
};

export default LibraryHeader;
