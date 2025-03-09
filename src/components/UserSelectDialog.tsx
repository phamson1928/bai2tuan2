
import React from 'react';
import { User } from '@/types/library';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { motion } from 'framer-motion';

interface UserSelectDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  users: User[];
  onSelectUser: (user: User) => void;
}

const UserSelectDialog: React.FC<UserSelectDialogProps> = ({
  open,
  onOpenChange,
  users,
  onSelectUser,
}) => {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md mx-auto p-6">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold text-center">Chọn nhân viên</DialogTitle>
        </DialogHeader>
        <div className="mt-4">
          <ul className="space-y-2 max-h-[60vh] overflow-y-auto">
            {users.map((user) => (
              <motion.li
                key={user.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className="animate-slide-up"
              >
                <Button
                  onClick={() => {
                    onSelectUser(user);
                    onOpenChange(false);
                  }}
                  variant="outline"
                  className="w-full justify-start text-left py-3 px-4 hover:bg-gray-50 transition-all duration-200"
                >
                  {user.name}
                </Button>
              </motion.li>
            ))}
          </ul>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default UserSelectDialog;
