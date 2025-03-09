
import React from 'react';
import { cn } from '@/lib/utils';
import { Book } from '@/types/library';
import { Check } from 'lucide-react';
import { motion } from 'framer-motion';

interface BookListProps {
  className?: string;
  books: Book[];
  borrowedBooks: string[];
  onToggleBook: (bookId: string) => void;
}

const BookList: React.FC<BookListProps> = ({ 
  className, 
  books,
  borrowedBooks,
  onToggleBook
}) => {
  return (
    <div className={cn('', className)}>
      <h2 className="text-lg font-medium mb-2">Danh sách sách</h2>
      <div className="bg-library-gray rounded-lg p-4">
        <ul className="space-y-2">
          {books.map((book) => {
            const isBorrowed = borrowedBooks.includes(book.id);
            
            return (
              <motion.li
                key={book.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className="book-item-transition"
              >
                <button
                  onClick={() => onToggleBook(book.id)}
                  className="w-full bg-white rounded-md p-3 flex items-center gap-3 hover:shadow-md transition-all duration-200 border border-gray-100"
                >
                  <div className={cn(
                    "w-5 h-5 flex-shrink-0 rounded border flex items-center justify-center transition-all duration-200",
                    isBorrowed ? "bg-library-blue border-library-blue" : "border-gray-300"
                  )}>
                    {isBorrowed && <Check size={16} className="text-white" />}
                  </div>
                  <span className="text-left font-medium text-library-text">{book.title}</span>
                </button>
              </motion.li>
            );
          })}
        </ul>
      </div>
    </div>
  );
};

export default BookList;
