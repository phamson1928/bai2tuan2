
import React, { useState } from 'react';
import { useToast } from '@/hooks/use-toast';
import LibraryHeader from '@/components/LibraryHeader';
import UserSelector from '@/components/UserSelector';
import BookList from '@/components/BookList';
import AddBookButton from '@/components/AddBookButton';
import AppNavigation from '@/components/AppNavigation';
import UserSelectDialog from '@/components/UserSelectDialog';
import AddBookDialog from '@/components/AddBookDialog';
import AnimatedWrapper from '@/components/AnimatedWrapper';
import { User, Book } from '@/types/library';
import { toast } from 'sonner';

const Index = () => {
  // Initial sample data
  const [users, setUsers] = useState<User[]>([
    { id: '1', name: 'Nguyen Van A', borrowedBooks: ['1', '2'] },
    { id: '2', name: 'Tran Thi B', borrowedBooks: ['3'] },
    { id: '3', name: 'Le Van C', borrowedBooks: [] }
  ]);
  
  const [books, setBooks] = useState<Book[]>([
    { id: '1', title: 'Sách 01' },
    { id: '2', title: 'Sách 02' },
    { id: '3', title: 'Sách 03' },
  ]);
  
  const [currentUser, setCurrentUser] = useState<User>(users[0]);
  const [isUserDialogOpen, setIsUserDialogOpen] = useState(false);
  const [isAddBookDialogOpen, setIsAddBookDialogOpen] = useState(false);

  // Handle user change
  const handleChangeUser = () => {
    setIsUserDialogOpen(true);
  };

  const handleSelectUser = (user: User) => {
    setCurrentUser(user);
    toast.success(`Đã chọn: ${user.name}`);
  };

  // Handle book operations
  const handleToggleBook = (bookId: string) => {
    // Clone the current users array
    const updatedUsers = [...users];
    
    // Find the current user in the cloned array
    const userIndex = updatedUsers.findIndex(u => u.id === currentUser.id);
    
    if (userIndex !== -1) {
      const user = updatedUsers[userIndex];
      
      // Check if the book is already borrowed
      const bookIndex = user.borrowedBooks.indexOf(bookId);
      
      if (bookIndex === -1) {
        // Add the book to borrowed books
        user.borrowedBooks = [...user.borrowedBooks, bookId];
        toast.success('Đã mượn sách');
      } else {
        // Remove the book from borrowed books
        user.borrowedBooks = user.borrowedBooks.filter(id => id !== bookId);
        toast.success('Đã trả sách');
      }
      
      // Update the users array and current user
      setUsers(updatedUsers);
      setCurrentUser(updatedUsers[userIndex]);
    }
  };

  const handleAddBook = (title: string) => {
    // Create a new book with a unique ID
    const newBook: Book = {
      id: String(Date.now()),
      title
    };
    
    // Add the new book to the books array
    setBooks([...books, newBook]);
  };

  return (
    <AnimatedWrapper className="min-h-screen pb-20">
      <div className="max-w-md mx-auto px-6">
        <LibraryHeader />
        
        <UserSelector 
          currentUser={currentUser} 
          onChangeUser={handleChangeUser} 
        />
        
        <BookList 
          books={books} 
          borrowedBooks={currentUser.borrowedBooks}
          onToggleBook={handleToggleBook}
        />
        
        <AddBookButton onClick={() => setIsAddBookDialogOpen(true)} />
      </div>
      
      <AppNavigation />
      
      <UserSelectDialog 
        open={isUserDialogOpen}
        onOpenChange={setIsUserDialogOpen}
        users={users}
        onSelectUser={handleSelectUser}
      />
      
      <AddBookDialog
        open={isAddBookDialogOpen}
        onOpenChange={setIsAddBookDialogOpen}
        onAddBook={handleAddBook}
      />
    </AnimatedWrapper>
  );
};

export default Index;
