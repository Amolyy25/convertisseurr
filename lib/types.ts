export interface FileWithPreview extends File {
  preview: string;
}

export type ImageFormat = 'jpg' | 'jpeg' | 'png' | 'webp' | 'gif' | 'svg' | 'heic';
export type VideoFormat = 'mp4' | 'mov' | 'avi' | 'webm' | 'mkv';

export type SupportedFormat = ImageFormat | VideoFormat;

export interface ConversionResult {
  url: string;
  fileName: string;
  format: SupportedFormat;
  size: number;
} 