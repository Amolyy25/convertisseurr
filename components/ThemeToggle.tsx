'use client';

import { useState, useEffect } from 'react';

const ThemeToggle = () => {
  const [darkMode, setDarkMode] = useState<boolean>(false);
  const [mounted, setMounted] = useState<boolean>(false);

  useEffect(() => {
    setMounted(true);
    // Vérifier si le mode sombre est déjà défini dans localStorage
    const isDarkMode = localStorage.getItem('darkMode') === 'true' || 
      (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches);
    
    setDarkMode(isDarkMode);
    
    // Appliquer le mode sombre si nécessaire
    if (isDarkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, []);

  const toggleDarkMode = () => {
    const newDarkMode = !darkMode;
    setDarkMode(newDarkMode);
    
    // Mettre à jour localStorage
    localStorage.setItem('darkMode', newDarkMode.toString());
    
    // Mettre à jour la classe sur l'élément HTML
    if (newDarkMode) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  if (!mounted) {
    // Rendu vide lors du chargement pour éviter les basculements brusques
    return <div className="w-10 h-10"></div>;
  }

  return (
    <button
      onClick={toggleDarkMode}
      className="relative inline-flex items-center justify-center w-10 h-10 rounded-full hover:bg-gray-200 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-primary/50 transition-colors"
      aria-label={darkMode ? 'Passer au mode clair' : 'Passer au mode sombre'}
    >
      <div className="absolute inset-0 overflow-hidden rounded-full">
        <div className={`absolute inset-0 transition-all duration-500 ease-in-out ${darkMode ? 'bg-gradient-to-br from-indigo-800 to-purple-900 opacity-20' : 'bg-gradient-to-tr from-yellow-200 to-orange-300 opacity-0'}`}></div>
      </div>
      
      <div className="relative">
        {/* Soleil */}
        <div className={`transform transition-all duration-500 ${darkMode ? 'scale-0 opacity-0' : 'scale-100 opacity-100'}`}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-5 w-5 text-amber-500"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"
            />
          </svg>
        </div>
        
        {/* Lune */}
        <div className={`absolute top-0 left-0 transform transition-all duration-500 ${darkMode ? 'scale-100 opacity-100' : 'scale-0 opacity-0'}`}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-5 w-5 text-indigo-300"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"
            />
          </svg>
        </div>
      </div>
      
      {/* Étoiles animées */}
      <div className={`absolute inset-0 transition-opacity duration-500 ${darkMode ? 'opacity-100' : 'opacity-0'}`}>
        <div className="absolute top-1 right-2 w-1 h-1 bg-white rounded-full animate-pulse" style={{ animationDelay: '0.1s' }}></div>
        <div className="absolute top-3 right-1 w-0.5 h-0.5 bg-white rounded-full animate-pulse" style={{ animationDelay: '0.5s' }}></div>
        <div className="absolute bottom-1 left-2 w-1 h-1 bg-white rounded-full animate-pulse" style={{ animationDelay: '0.8s' }}></div>
        <div className="absolute bottom-2 right-3 w-0.5 h-0.5 bg-white rounded-full animate-pulse" style={{ animationDelay: '0.3s' }}></div>
      </div>
    </button>
  );
};

export default ThemeToggle; 