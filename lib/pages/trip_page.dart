/*
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sharing_codelab/components/contribute_photo_dialog.dart';
import 'package:sharing_codelab/components/app_bar.dart';
import 'package:sharing_codelab/components/dialogs.dart';
import 'package:sharing_codelab/components/menus.dart';
import 'package:sharing_codelab/components/photo_grid.dart';
import 'package:sharing_codelab/model/photos_library_api_model.dart';
import 'package:sharing_codelab/photos_library_api/album.dart';
import 'package:sharing_codelab/photos_library_api/search_media_items_response.dart';
import 'package:sharing_codelab/util/to_be_implemented.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key key, this.searchResponse, this.album}) : super(key: key);

  final Future<SearchMediaItemsResponse> searchResponse;

  final Album album;

  @override
  State<StatefulWidget> createState() =>
      _TripPageState(searchResponse: searchResponse, album: album);
}

class _TripPageState extends State<TripPage> {
  _TripPageState({ this.searchResponse, this.album });

  Album album;
  Future<SearchMediaItemsResponse> searchResponse;
  bool _processingUpload = false;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _scrollViewController =ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AlbumAppBar(
      album: album,
      onMenuSelect: onMenuSelect,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<SearchMediaItemsResponse>(
        future: searchResponse,
        builder: (ctx, snapshot) {
          final body = _buildTripPageBody(snapshot);

          return CustomScrollView(
            controller: _scrollViewController,
            slivers: <Widget>[
              appBar,
              body,
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add photo',
        onPressed: () => _contributePhoto(context),
      ),
    );
  }

  void _contributePhoto(BuildContext context) async {
    final apiModel = ScopedModel.of<PhotosLibraryApiModel>(context);

    final result = await showDialog<ContributePhotoResult>(
      context: context,
      builder: (BuildContext context) => ContributePhotoDialog(),
    );

    if (result != null) {
      setState(() {
        _processingUpload = true;
      });

      await apiModel.createMediaItem(
                result.uploadToken, album.id, result.description);

      setState(() {
        _processingUpload = false;
        searchResponse = apiModel.searchMediaItems(album.id);
      });
    }
  }

  SliverFillRemaining _wrapInSliver(Widget child) => SliverFillRemaining(
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(48),
      child: child,
    ),
  );

  Widget _buildTripPageBody(AsyncSnapshot<SearchMediaItemsResponse> snapshot) {
    if (snapshot.hasData && _processingUpload == false) {
      if (snapshot.data.isEmpty) {
        return _wrapInSliver(const Text(
          'No photos in this trip album yet! Feel free to add some',
          textAlign: TextAlign.center,
        ));
      }

      return PhotoGrid(photos: snapshot.data.mediaItems);
    }

    if (snapshot.hasError) {
      print(snapshot.error);
      return _wrapInSliver(
        const Text(
          'An error occurred while loading photos',
          textAlign: TextAlign.center,
        ),
      );
    }

    return _wrapInSliver(const CircularProgressIndicator());
  }

  Future<void> onMenuSelect(
      BuildContext context, AlbumMenuOptions selection) async {
    if (selection == AlbumMenuOptions.shareWithAnyone) {
      _showShareableUrl(context);
    }
    else {
      _showShareToken(context);
    }
  }

  Future<void> _shareAlbum(BuildContext context) async {
    // TODO(codelab): Implement this method.
    ToBeImplemented.showMessage();

    // // If the album is not shared yet, call the Library API to share it and
    // // update the local model

    // // Once the album contains the shareInfo data, display its share token
    // final apiModel = ScopedModel.of<PhotosLibraryApiModel>(context);
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   duration: Duration(seconds: 3),
    //   content: const Text('Sharing Album...'),
    // ));
    // // Share the album and update the local model
    // await apiModel.shareAlbum(album.id);
    // final updatedAlbum = await apiModel.getAlbum(album.id);
    // print('Album has been shared.');
    // setState(() {
    //   album = updatedAlbum;
    // });
  }

  void _showShareableUrl(BuildContext context) {
    // TODO(codelab): Implement this method.
    ToBeImplemented.showMessage();

    // if (album?.shareInfo?.shareableUrl != null) {
    //   // Album is already shared, display dialog with URL
    //   _showUrlDialog(context);
    // } else {
    //   print('Not shared, sharing album first.');
    //   // Album is not shared yet, share it first, then display dialog
    //   _shareAlbum(context).then((_) {
    //     _showUrlDialog(context);
    //   });
    // }
  }

  void _showShareToken(BuildContext context) {
    // TODO(codelab): Implement this method.
    ToBeImplemented.showMessage();

    // if (album?.shareInfo?.shareToken != null) {
    //   // Album is already shared, display dialog with URL
    //   _showTokenDialog(context);
    // } else {
    //   print('Not shared, sharing album first.');
    //   // Album is not shared yet, share it first, then display dialog
    //   _shareAlbum(context).then((_) {
    //     _showTokenDialog(context);
    //   });
    // }
  }

  void _showTokenDialog(BuildContext context) {
    // TODO(codelab): Implement this method.
    ToBeImplemented.showMessage();

    // print('This is the shareToken:\n${album.shareInfo.shareToken}');

    // _showShareDialog(
    //     context, 'Use this token to share', album.shareInfo.shareToken);
  }

  void _showUrlDialog(BuildContext context) {
    // TODO(codelab): Implement this method.
    ToBeImplemented.showMessage();

    // print('This is the shareableUrl:\n${album.shareInfo.shareableUrl}');

    // _showShareDialog(
    //     context,
    //     'Share this URL with anyone. '
    //     'Anyone with this URL can access all items.',
    //     album.shareInfo.shareableUrl);
  }

  void _showShareDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TextDialog(
        title: title,
        text: text,
      ));
  }
}
