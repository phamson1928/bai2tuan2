
import React from 'react';
import { cn } from '@/lib/utils';
import { User } from '@/types/library';
import { Button } from '@/components/ui/button';

interface UserSelectorProps {
  className?: string;
  currentUser: User;
  onChangeUser: () => void;
}

const UserSelector: React.FC<UserSelectorProps> = ({ 
  className, 
  currentUser,
  onChangeUser
}) => {
  return (
    <div className={cn('mb-8', className)}>
      <h2 className="text-lg font-medium mb-2">Nhân viên</h2>
      <div className="flex items-center gap-2">
        <input
          type="text"
          value={currentUser.name}
          readOnly
          className="flex-1 rounded-md border border-gray-300 px-4 py-2 focus:outline-none focus:ring-2 focus:ring-library-blue focus:border-transparent transition-all duration-200"
        />
        <Button 
          onClick={onChangeUser}
          className="bg-library-blue hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-md transition-all duration-200"
        >
          Đổi
        </Button>
      </div>
    </div>
  );
};

export default UserSelector;
