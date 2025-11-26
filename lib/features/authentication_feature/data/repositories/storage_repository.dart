import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageRepository {
  final supabase=Supabase.instance.client.storage;

  uploadImage(File image)async{
    const bucket = 'store_profile_pic';
    final fileName = image.path.split('/').last;
    final path = 'images/$fileName';
    await supabase.from(bucket).upload(path, image, fileOptions: FileOptions(upsert: true));
    return supabase.from(bucket).getPublicUrl(path);
  }
}