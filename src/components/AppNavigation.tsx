
import React from 'react';
import { cn } from '@/lib/utils';
import { Home, BookOpen, User } from 'lucide-react';
import { useLocation, Link } from 'react-router-dom';

interface AppNavigationProps {
  className?: string;
}

const AppNavigation: React.FC<AppNavigationProps> = ({ className }) => {
  const location = useLocation();
  const path = location.pathname;

  const navItems = [
    { icon: Home, label: 'Quản lý', path: '/' },
    { icon: BookOpen, label: 'DS sách', path: '/books' },
    { icon: User, label: 'Nhân viên', path: '/users' },
  ];

  return (
    <nav className={cn(
      'fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 py-2',
      className
    )}>
      <div className="flex justify-around items-center max-w-md mx-auto">
        {navItems.map((item) => {
          const isActive = item.path === path;
          
          return (
            <Link
              key={item.path}
              to={item.path}
              className={cn(
                'flex flex-col items-center p-2 transition-all duration-200',
                isActive ? 'text-library-blue tab-active' : 'text-gray-500'
              )}
            >
              <item.icon size={24} />
              <span className="text-xs mt-1">{item.label}</span>
            </Link>
          );
        })}
      </div>
    </nav>
  );
};

export default AppNavigation;
