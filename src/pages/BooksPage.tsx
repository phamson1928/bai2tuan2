
import React, { useState } from 'react';
import { Book } from '@/types/library';
import AppNavigation from '@/components/AppNavigation';
import AnimatedWrapper from '@/components/AnimatedWrapper';
import { Button } from '@/components/ui/button';
import { Plus, Edit, Trash2 } from 'lucide-react';
import AddBookDialog from '@/components/AddBookDialog';
import { toast } from 'sonner';

const BooksPage = () => {
  const [books, setBooks] = useState<Book[]>([
    { id: '1', title: 'Sách 01' },
    { id: '2', title: 'Sách 02' },
    { id: '3', title: 'Sách 03' },
  ]);
  
  const [isAddBookDialogOpen, setIsAddBookDialogOpen] = useState(false);

  const handleAddBook = (title: string) => {
    const newBook: Book = {
      id: String(Date.now()),
      title
    };
    
    setBooks([...books, newBook]);
  };

  const handleDeleteBook = (id: string) => {
    setBooks(books.filter(book => book.id !== id));
    toast.success('Đã xóa sách');
  };

  return (
    <AnimatedWrapper className="min-h-screen pb-20">
      <div className="max-w-md mx-auto px-6 py-8">
        <header className="flex items-center justify-between mb-6">
          <h1 className="text-2xl font-bold">Danh sách sách</h1>
          <Button 
            onClick={() => setIsAddBookDialogOpen(true)}
            className="bg-library-blue hover:bg-blue-700"
            size="sm"
          >
            <Plus size={16} className="mr-1" />
            Thêm
          </Button>
        </header>
        
        <div className="bg-white rounded-lg shadow-sm border border-gray-100">
          {books.length === 0 ? (
            <div className="py-8 text-center text-gray-500">
              Chưa có sách nào
            </div>
          ) : (
            <ul className="divide-y divide-gray-100">
              {books.map((book) => (
                <li key={book.id} className="p-4 flex items-center justify-between">
                  <span className="font-medium">{book.title}</span>
                  <div className="flex gap-2">
                    <Button variant="ghost" size="icon" className="h-8 w-8 text-gray-500 hover:text-blue-600">
                      <Edit size={16} />
                    </Button>
                    <Button 
                      variant="ghost" 
                      size="icon" 
                      className="h-8 w-8 text-gray-500 hover:text-red-600"
                      onClick={() => handleDeleteBook(book.id)}
                    >
                      <Trash2 size={16} />
                    </Button>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
      
      <AppNavigation />
      
      <AddBookDialog
        open={isAddBookDialogOpen}
        onOpenChange={setIsAddBookDialogOpen}
        onAddBook={handleAddBook}
      />
    </AnimatedWrapper>
  );
};

export default BooksPage;
