#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public static class DeleteSaveCache
{
    [MenuItem("Save/ Delete Saved Data")]
    public static bool DeleteSaveData()
    {
        const string fileName = "player_save.data";
        string path = Application.persistentDataPath + '/' + fileName;
        if (File.Exists(path))
        {
            File.Delete(path);
            Debug.Log("File (" + fileName + ") deleted");
            return true;
        }
        else
        {
            Debug.Log("File (" + fileName + ") does not exist");
            return false;
        }
    }
}
#endif
