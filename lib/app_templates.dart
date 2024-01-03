import 'app_constants.dart';

List<String> templateProjectSubfolders = [
  'Chapters',
  'Characters',
  'Locations',
  'Research',
  'Recycle Bin',
];

String templateProjectOverview(String projectName, String projectDescription,
    String projectCopyrightHolder, String projectCreationDate) {
  return '''
  <projectVersion>$projectVersion</projectVersion>
  <projectName>$projectName</projectName>
  <projectDescription>
    $projectDescription
  </projectDescription>
  <projectCreationDate>$projectCreationDate</projectCreationDate>
  ''';
}


String fileTypeOverview = '.tale';
String fileTypeChapter = '.tale_chap';
String fileTypeCharacter = '.tale_char';
String fileTypeLocation = '.tale_local';
String fileTypeResearch = '.tale_res';
