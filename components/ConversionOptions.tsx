'use client';

import { useState, useEffect } from 'react';
import { FileWithPreview, ImageFormat, VideoFormat } from '../lib/types';

interface ConversionOptionsProps {
  file: FileWithPreview | null;
  targetFormat: string;
  onFormatChange: (format: string) => void;
  onConvert: () => void;
  isConverting: boolean;
}

const ConversionOptions = ({
  file,
  targetFormat,
  onFormatChange,
  onConvert,
  isConverting,
}: ConversionOptionsProps) => {
  const [fileType, setFileType] = useState<'image' | 'video' | null>(null);
  const [quality, setQuality] = useState<number>(80);
  
  const imageFormats: ImageFormat[] = ['jpg', 'jpeg', 'png', 'webp', 'gif'];
  const videoFormats: VideoFormat[] = ['mp4', 'webm', 'mov', 'avi'];

  useEffect(() => {
    if (file) {
      if (file.type.startsWith('image/')) {
        setFileType('image');
      } else if (file.type.startsWith('video/')) {
        setFileType('video');
      } else {
        setFileType(null);
      }
    } else {
      setFileType(null);
    }
  }, [file]);

  const getAvailableFormats = () => {
    if (fileType === 'image') {
      return imageFormats.filter(format => {
        // Filtrer le format actuel de l'image si on peut le détecter
        const currentFormat = file?.type.split('/')[1];
        return format !== currentFormat;
      });
    } else if (fileType === 'video') {
      return videoFormats.filter(format => {
        // Filtrer le format actuel de la vidéo si on peut le détecter
        const currentFormat = file?.type.split('/')[1];
        return format !== currentFormat;
      });
    }
    return [];
  };

  return (
    <div>
      {!file ? (
        <div className="text-center p-8 text-gray-500 border-2 border-dashed border-gray-200 dark:border-gray-700 rounded-xl">
          <svg
            className="mx-auto h-12 w-12 text-gray-400 mb-3 opacity-50"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={1.5}
              d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
            />
          </svg>
          <p className="mt-2">Veuillez d'abord télécharger un fichier</p>
          <p className="text-sm mt-1 text-gray-400">Les options de conversion s'afficheront ici</p>
        </div>
      ) : (
        <>
          <div className="mb-6 relative">
            <label htmlFor="format-select" className="block text-sm font-medium mb-2 flex items-center">
              <svg className="w-4 h-4 mr-1.5 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
              </svg>
              Format de destination
            </label>
            <div className="relative">
              <select
                id="format-select"
                value={targetFormat}
                onChange={(e) => onFormatChange(e.target.value)}
                className="w-full p-3 border border-gray-300 dark:border-gray-700 rounded-xl focus:ring-2 focus:ring-primary focus:border-transparent bg-white dark:bg-gray-800 appearance-none pr-10 transition-all duration-200"
                disabled={isConverting}
              >
                <option value="" disabled>
                  Sélectionnez un format
                </option>
                {getAvailableFormats().map((format) => (
                  <option key={format} value={format}>
                    {format.toUpperCase()}
                  </option>
                ))}
              </select>
              <div className="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none text-gray-500">
                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                </svg>
              </div>
            </div>
          </div>

          <div className="mb-8">
            <label className="block text-sm font-medium mb-2 flex items-center">
              <svg className="w-4 h-4 mr-1.5 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
              </svg>
              Qualité ({quality}%)
            </label>
            <div className="flex items-center">
              <input
                type="range"
                min="10"
                max="100"
                value={quality}
                onChange={(e) => setQuality(parseInt(e.target.value))}
                className="w-full h-2 bg-gray-200 dark:bg-gray-700 rounded-lg appearance-none cursor-pointer accent-primary"
                disabled={isConverting || !targetFormat}
              />
              <span className="ml-3 text-sm w-10 text-center">{quality}%</span>
            </div>
            <div className="flex justify-between text-xs text-gray-500 mt-1 px-1">
              <span>Compression</span>
              <span>Qualité</span>
            </div>
          </div>

          <button
            onClick={onConvert}
            disabled={isConverting || !targetFormat}
            className={`w-full btn group relative overflow-hidden ${
              isConverting || !targetFormat
                ? 'bg-gray-300 dark:bg-gray-700 cursor-not-allowed text-gray-500 dark:text-gray-400'
                : 'btn-primary shine'
            }`}
          >
            <span className="relative z-10 flex items-center justify-center">
              {isConverting ? (
                <>
                  <svg
                    className="animate-spin -ml-1 mr-2 h-5 w-5 text-white"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 24 24"
                  >
                    <circle
                      className="opacity-25"
                      cx="12"
                      cy="12"
                      r="10"
                      stroke="currentColor"
                      strokeWidth="4"
                    ></circle>
                    <path
                      className="opacity-75"
                      fill="currentColor"
                      d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                    ></path>
                  </svg>
                  Conversion en cours...
                </>
              ) : (
                <>
                  <svg className="w-5 h-5 mr-2 group-hover:animate-bounce-gentle" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                  </svg>
                  Convertir
                </>
              )}
            </span>
          </button>
          
          {!isConverting && targetFormat && (
            <div className="mt-5 text-center">
              <p className="text-xs text-gray-500">
                {fileType === 'image' 
                  ? `La conversion de ${file.type.split('/')[1]} vers ${targetFormat} sera effectuée en local` 
                  : `La vidéo sera convertie de ${file.type.split('/')[1]} vers ${targetFormat}`}
              </p>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default ConversionOptions; 