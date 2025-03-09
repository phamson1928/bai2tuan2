
import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { toast } from 'sonner';

interface AddBookDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  onAddBook: (title: string) => void;
}

const AddBookDialog: React.FC<AddBookDialogProps> = ({
  open,
  onOpenChange,
  onAddBook,
}) => {
  const [bookTitle, setBookTitle] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!bookTitle.trim()) {
      toast.error('Vui lòng nhập tên sách');
      return;
    }
    
    onAddBook(bookTitle);
    setBookTitle('');
    onOpenChange(false);
    toast.success('Đã thêm sách mới');
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-md mx-auto p-6">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold text-center">Thêm sách mới</DialogTitle>
        </DialogHeader>
        <form onSubmit={handleSubmit} className="mt-4 space-y-4">
          <div className="space-y-2">
            <Label htmlFor="bookTitle">Tên sách</Label>
            <Input
              id="bookTitle"
              value={bookTitle}
              onChange={(e) => setBookTitle(e.target.value)}
              placeholder="Nhập tên sách"
              className="w-full"
              autoFocus
            />
          </div>
          <DialogFooter className="mt-6">
            <Button type="button" variant="outline" onClick={() => onOpenChange(false)} className="mr-2">
              Hủy
            </Button>
            <Button type="submit" className="bg-library-blue hover:bg-blue-700">
              Thêm
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
};

export default AddBookDialog;
