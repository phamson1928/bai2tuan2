
import React from 'react';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';

interface AddBookButtonProps {
  className?: string;
  onClick: () => void;
}

const AddBookButton: React.FC<AddBookButtonProps> = ({ className, onClick }) => {
  return (
    <Button
      onClick={onClick}
      className={cn(
        "w-full bg-library-blue hover:bg-blue-700 text-white font-medium py-3 rounded-md transition-all duration-200 mt-6",
        className
      )}
    >
      Thêm
    </Button>
  );
};

export default AddBookButton;
