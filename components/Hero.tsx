'use client';

import { useEffect, useRef } from 'react';
import { useInView } from 'react-intersection-observer';

export default function Hero() {
  const { ref, inView } = useInView({
    threshold: 0.3,
    triggerOnce: true,
  });

  const iconRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const icon = iconRef.current;
    
    if (icon) {
      const handleMouseMove = (e: MouseEvent) => {
        const { left, top, width, height } = icon.getBoundingClientRect();
        const x = (e.clientX - left - width / 2) / 25;
        const y = (e.clientY - top - height / 2) / 25;
        
        icon.style.transform = `translate(${x}px, ${y}px) rotate(${x / 2}deg)`;
      };
      
      document.addEventListener('mousemove', handleMouseMove);
      
      return () => {
        document.removeEventListener('mousemove', handleMouseMove);
      };
    }
  }, []);

  return (
    <div className="py-16 md:py-24 overflow-hidden">
      <div 
        ref={ref}
        className={`container mx-auto px-4 flex flex-col md:flex-row items-center justify-between gap-8 transition-all duration-1000 ${
          inView ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'
        }`}
      >
        <div className="md:w-1/2 text-center md:text-left">
          <h1 className="text-3xl md:text-4xl lg:text-5xl font-bold mb-4 leading-tight">
            <span className="text-primary">Convertissez</span> vos fichiers images et vidéos facilement
          </h1>
          <p className="text-lg text-gray-600 dark:text-gray-300 mb-8 max-w-lg mx-auto md:mx-0">
            Solution simple, rapide et sécurisée pour transformer vos médias en différents formats sans perdre en qualité.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center md:justify-start">
            <button className="btn btn-primary flex items-center justify-center gap-2">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
              </svg>
              Démarrer maintenant
            </button>
            <a 
              href="#features" 
              className="btn border border-gray-300 dark:border-gray-700 hover:bg-gray-100 dark:hover:bg-gray-800"
            >
              En savoir plus
            </a>
          </div>
        </div>
        
        <div 
          ref={iconRef}
          className="md:w-1/2 p-6 transition-transform duration-200 ease-out"
        >
          <div className="relative w-64 h-64 mx-auto">
            <div className="absolute inset-0 bg-gradient-to-br from-primary/30 to-secondary/20 rounded-full blur-xl animate-pulse-gentle"></div>
            <div className="relative z-10 w-full h-full flex items-center justify-center">
              <svg 
                className="w-40 h-40 text-primary dark:text-accent floating" 
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24" 
                xmlns="http://www.w3.org/2000/svg"
              >
                <path 
                  strokeLinecap="round" 
                  strokeLinejoin="round" 
                  strokeWidth="1.5" 
                  d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
                ></path>
              </svg>
              <svg 
                className="absolute -right-4 -bottom-4 w-20 h-20 text-secondary dark:text-accent floating" 
                style={{ animationDelay: '1s' }}
                fill="none" 
                stroke="currentColor" 
                viewBox="0 0 24 24" 
                xmlns="http://www.w3.org/2000/svg"
              >
                <path 
                  strokeLinecap="round" 
                  strokeLinejoin="round" 
                  strokeWidth="1.5" 
                  d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"
                ></path>
                <path 
                  strokeLinecap="round" 
                  strokeLinejoin="round" 
                  strokeWidth="1.5" 
                  d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                ></path>
              </svg>
              <div className="absolute -bottom-2 -left-2 w-12 h-12 rounded-full bg-accent/20 dark:bg-accent/30 animate-bounce-gentle" style={{ animationDelay: '0.5s' }}></div>
              <div className="absolute -top-2 -right-4 w-8 h-8 rounded-full bg-primary/20 dark:bg-primary/30 animate-bounce-gentle" style={{ animationDelay: '1.2s' }}></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
} 