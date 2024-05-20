export function path2MimeType(path: string) :string{
  let index = path.lastIndexOf(".");
  let suffix = path.substring(index + 1);
  let mimeType = "text/html";
  switch (suffix) {
    case "html":
      mimeType = "text/html";
      break;
    case "js":
      mimeType = "text/javascript";
      break;
    case "css":
      mimeType = "text/css";
      break;
    case "png":
      mimeType = "image/png";
      break;
    case "jpg":
      mimeType = "image/jpeg";
      break;
    case "gif":
      mimeType = "image/gif";
      break;
    case "svg":
      mimeType = "image/svg+xml";
      break;
    case "ico":
      mimeType = "image/x-icon";
      break;
    case "json":
      mimeType = "application/json";
      break;
    case "xml":
      mimeType = "application/xml";
      break;
    case "pdf":
      mimeType = "application/pdf";
      break;
    case "zip":
      mimeType = "application/zip";
      break;
    case "mp3":
      mimeType = "audio/mpeg";
      break;
    case "mp4":
      mimeType = "video/mp4";
      break;
    default:
      mimeType = "text/html";
      break;
  }
  return mimeType;
}