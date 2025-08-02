String fixImageUrl(String url) {
  if (url.contains('/media/') && !url.contains('/api/v1/')) {
    return url.replaceFirst('/media/', '/api/v1/media/');
  }
  return url;
}

