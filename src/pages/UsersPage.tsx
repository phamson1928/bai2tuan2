
import React, { useState } from 'react';
import { User } from '@/types/library';
import AppNavigation from '@/components/AppNavigation';
import AnimatedWrapper from '@/components/AnimatedWrapper';
import { Button } from '@/components/ui/button';
import { Plus, BookOpen, User as UserIcon } from 'lucide-react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from 'sonner';

const UsersPage = () => {
  const [users, setUsers] = useState<User[]>([
    { id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2'] },
    { id: '2', name: 'Tran Thi B', borrowedBooks: ['3'] },
    { id: '3', name: 'Le Van C', borrowedBooks: [] }
  ]);
  
  const [isAddUserDialogOpen, setIsAddUserDialogOpen] = useState(false);
  const [newUserName, setNewUserName] = useState('');

  const handleAddUser = () => {
    if (!newUserName.trim()) {
      toast.error('Vui lòng nhập tên nhân viên');
      return;
    }
    
    const newUser: User = {
      id: String(Date.now()),
      name: newUserName,
      borrowedBooks: []
    };
    
    setUsers([...users, newUser]);
    setNewUserName('');
    setIsAddUserDialogOpen(false);
    toast.success('Đã thêm nhân viên mới');
  };

  return (
    <AnimatedWrapper className="min-h-screen pb-20">
      <div className="max-w-md mx-auto px-6 py-8">
        <header className="flex items-center justify-between mb-6">
          <h1 className="text-2xl font-bold">Danh sách nhân viên</h1>
          <Button 
            onClick={() => setIsAddUserDialogOpen(true)}
            className="bg-library-blue hover:bg-blue-700"
            size="sm"
          >
            <Plus size={16} className="mr-1" />
            Thêm
          </Button>
        </header>
        
        <div className="bg-white rounded-lg shadow-sm border border-gray-100">
          {users.length === 0 ? (
            <div className="py-8 text-center text-gray-500">
              Chưa có nhân viên nào
            </div>
          ) : (
            <ul className="divide-y divide-gray-100">
              {users.map((user) => (
                <li key={user.id} className="p-4">
                  <div className="flex items-center mb-2">
                    <UserIcon size={16} className="text-gray-500 mr-2" />
                    <span className="font-medium">{user.name}</span>
                  </div>
                  <div className="flex items-center text-sm text-gray-500 ml-6">
                    <BookOpen size={14} className="mr-1" />
                    <span>{user.borrowedBooks.length} sách đã mượn</span>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
      
      <AppNavigation />
      
      <Dialog open={isAddUserDialogOpen} onOpenChange={setIsAddUserDialogOpen}>
        <DialogContent className="max-w-md mx-auto p-6">
          <DialogHeader>
            <DialogTitle className="text-xl font-bold text-center">Thêm nhân viên mới</DialogTitle>
          </DialogHeader>
          <div className="mt-4 space-y-4">
            <div className="space-y-2">
              <Label htmlFor="userName">Tên nhân viên</Label>
              <Input
                id="userName"
                value={newUserName}
                onChange={(e) => setNewUserName(e.target.value)}
                placeholder="Nhập tên nhân viên"
                className="w-full"
                autoFocus
              />
            </div>
            <DialogFooter className="mt-6">
              <Button type="button" variant="outline" onClick={() => setIsAddUserDialogOpen(false)} className="mr-2">
                Hủy
              </Button>
              <Button onClick={handleAddUser} className="bg-library-blue hover:bg-blue-700">
                Thêm
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </AnimatedWrapper>
  );
};

export default UsersPage;
