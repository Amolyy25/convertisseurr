'use client';

import { useCallback, useEffect, useState } from 'react';
import { useDropzone } from 'react-dropzone';
import Image from 'next/image';
import { FileWithPreview } from '../lib/types';

interface FileUploaderProps {
  onFileChange: (file: FileWithPreview | null) => void;
  file: FileWithPreview | null;
}

const FileUploader = ({ onFileChange, file }: FileUploaderProps) => {
  const [isDragging, setIsDragging] = useState(false);
  const [dragTimeout, setDragTimeout] = useState<NodeJS.Timeout | null>(null);

  const onDrop = useCallback(
    (acceptedFiles: File[]) => {
      if (acceptedFiles.length > 0) {
        const file = acceptedFiles[0];
        const fileWithPreview = Object.assign(file, {
          preview: URL.createObjectURL(file),
        }) as FileWithPreview;
        
        onFileChange(fileWithPreview);
      }
    },
    [onFileChange]
  );

  const { getRootProps, getInputProps, isDragActive, open } = useDropzone({
    onDrop,
    maxFiles: 1,
    accept: {
      'image/*': ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg', '.heic'],
      'video/*': ['.mp4', '.mov', '.avi', '.webm', '.mkv'],
    },
    noClick: true, // Désactive le clic pour ouvrir la boîte de dialogue
  });

  // Nettoyer les URL d'objets pour éviter les fuites de mémoire
  useEffect(() => {
    return () => {
      if (file) {
        URL.revokeObjectURL(file.preview);
      }
    };
  }, [file]);

  // Effet de traînée amélioré
  useEffect(() => {
    if (isDragActive) {
      setIsDragging(true);
      if (dragTimeout) {
        clearTimeout(dragTimeout);
        setDragTimeout(null);
      }
    } else if (isDragging) {
      const timeout = setTimeout(() => {
        setIsDragging(false);
      }, 150);
      setDragTimeout(timeout);
    }
    
    return () => {
      if (dragTimeout) {
        clearTimeout(dragTimeout);
      }
    };
  }, [isDragActive, isDragging, dragTimeout]);

  const handleRemoveFile = () => {
    if (file) {
      URL.revokeObjectURL(file.preview);
      onFileChange(null);
    }
  };

  return (
    <div className="transition-all duration-300">
      <div
        {...getRootProps()}
        className={`relative overflow-hidden border-2 border-dashed rounded-2xl p-8 text-center transition-all duration-300 ${
          isDragging
            ? 'border-primary bg-primary/10 shadow-lg scale-102'
            : 'border-gray-300 hover:border-primary/50 hover:shadow-soft'
        }`}
      >
        <input {...getInputProps()} />
        
        {/* Animated background elements */}
        <div className="absolute inset-0 -z-10 opacity-10">
          <div className="absolute -top-6 -left-6 w-16 h-16 bg-primary rounded-full animate-pulse-gentle opacity-70"></div>
          <div className="absolute top-1/3 -right-6 w-12 h-12 bg-secondary rounded-full animate-pulse-gentle opacity-70" style={{ animationDelay: '1s' }}></div>
          <div className="absolute -bottom-6 left-1/3 w-14 h-14 bg-accent rounded-full animate-pulse-gentle opacity-70" style={{ animationDelay: '2s' }}></div>
        </div>
        
        {isDragging ? (
          <div className="py-8">
            <div className="w-16 h-16 mx-auto mb-4 text-primary animate-bounce-gentle">
              <svg
                stroke="currentColor"
                fill="none"
                viewBox="0 0 24 24"
                aria-hidden="true"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={1.5}
                  d="M19 9l-7 7-7-7"
                />
              </svg>
            </div>
            <p className="text-primary font-medium text-lg">Déposez le fichier ici...</p>
          </div>
        ) : (
          <div className="py-6">
            <svg
              className="mx-auto h-14 w-14 text-gray-400 mb-4 floating"
              stroke="currentColor"
              fill="none"
              viewBox="0 0 48 48"
              aria-hidden="true"
            >
              <path
                d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02"
                strokeWidth={1.5}
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
            <p className="mt-4 text-base text-gray-600 dark:text-gray-300">
              Glissez-déposez une image ou vidéo ici
            </p>
            <p className="mt-1 text-sm text-gray-500">
              ou
            </p>
            <button
              type="button"
              onClick={open}
              className="mt-3 btn btn-primary text-sm px-4 py-1.5 inline-flex items-center"
            >
              <svg className="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
              Sélectionner un fichier
            </button>
            <p className="mt-4 text-xs text-gray-500">
              Formats supportés: JPG, PNG, WEBP, HEIC, MP4, MOV, AVI...
            </p>
          </div>
        )}
      </div>

      {file && (
        <div className="mt-6 card" style={{ transitionDelay: '100ms' }}>
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center space-x-3">
              <div className="p-2 rounded-full bg-primary/10 text-primary dark:text-accent">
                {file.type.startsWith('image/') ? (
                  <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M4 3a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V5a2 2 0 00-2-2H4zm12 12H4l4-8 3 6 2-4 3 6z" clipRule="evenodd" />
                  </svg>
                ) : (
                  <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M2 6a2 2 0 012-2h6a2 2 0 012 2v8a2 2 0 01-2 2H4a2 2 0 01-2-2V6zM14.553 7.106A1 1 0 0014 8v4a1 1 0 00.553.894l2 1A1 1 0 0018 13V7a1 1 0 00-1.447-.894l-2 1z" />
                  </svg>
                )}
              </div>
              <div>
                <h3 className="font-medium truncate max-w-[200px] sm:max-w-xs">
                  {file.name}
                </h3>
                <p className="text-xs text-gray-500">
                  {file.type} · {(file.size / 1024 / 1024).toFixed(2)} MB
                </p>
              </div>
            </div>
            <button
              onClick={handleRemoveFile}
              className="text-red-500 hover:text-red-700 hover:bg-red-50 dark:hover:bg-red-950/30 p-1.5 rounded-full transition-colors"
              type="button"
              aria-label="Supprimer le fichier"
            >
              <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
              </svg>
            </button>
          </div>
          <div className="relative h-56 rounded-xl overflow-hidden bg-gray-100 dark:bg-gray-800">
            {file.type.startsWith('image/') ? (
              <Image
                src={file.preview}
                alt={file.name}
                fill
                className="object-contain transition-opacity duration-300 hover:opacity-90"
                sizes="(max-width: 640px) 100vw, 640px"
              />
            ) : file.type.startsWith('video/') ? (
              <video
                src={file.preview}
                controls
                className="w-full h-full object-contain"
              />
            ) : (
              <div className="flex items-center justify-center h-full">
                <p className="text-gray-500">Aperçu non disponible</p>
              </div>
            )}
            <div className="absolute bottom-2 right-2 bg-black/60 text-white text-xs px-2 py-1 rounded-md">
              {file.type.split('/')[1].toUpperCase()}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default FileUploader; 