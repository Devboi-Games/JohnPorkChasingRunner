using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Linq;


[System.Serializable]
public class PlayerData
{
    public const string VERSION = "0.01";

    public string version;
    public DateTime last_save;
    public Dictionary<string, int> unique_ids = new Dictionary<string, int>();

    //--------------------------------

    public float score = 0;
    public int currentLevel = 1;
    public int selectedSkin;
    public HashSet<int> unlockedSkins = new HashSet<int>() { 0 };

    public static PlayerData player_data = null;

    public PlayerData()
    {
        version = VERSION;
        last_save = DateTime.Now;
    }

    public void FixData()
    {
        //Fix data to make sure old save files compatible with new game version
        if (unique_ids == null)
            unique_ids = new Dictionary<string, int>();
    }

    public void SaveGame(string name)
    {
        last_save = System.DateTime.Now;
        version = VERSION;
        SaveSystem.Save(name, PlayerData.player_data);
    }

    public static void NewGame()
    {
        player_data = new PlayerData();
    }

    public static void Save()
    {
        string save = SaveSystem.GetLastSave();
        if (string.IsNullOrEmpty(save))
            save = "player"; //Default game name
        if (player_data != null)
            player_data.SaveGame(save);
    }

    public static void Save(string name)
    {
        if (player_data != null)
            player_data.SaveGame(name);
    }

    public static void Load()
    {
        if (player_data == null)
            player_data = SaveSystem.Load(SaveSystem.GetLastSave());
        if (player_data == null)
            player_data = new PlayerData();
        player_data.FixData();
    }

    public static void Load(string name)
    {
        if (player_data == null)
            player_data = SaveSystem.Load(name);
        if (player_data == null)
            player_data = new PlayerData();
        player_data.FixData();
    }

    public static void Unload()
    {
        player_data = null;
        SaveSystem.Unload();
    }

    public static bool IsLoaded()
    {
        return player_data != null;
    }

    // ---- Unique Ids ----
    public void SetUniqueID(string unique_id, int val)
    {
        if (!string.IsNullOrEmpty(unique_id))
        {
            if (!unique_ids.ContainsKey(unique_id))
                unique_ids[unique_id] = val;
        }
    }

    public void RemoveUniqueID(string unique_id)
    {
        if (unique_ids.ContainsKey(unique_id))
            unique_ids.Remove(unique_id);
    }

    public int GetUniqueID(string unique_id)
    {
        if (unique_ids.ContainsKey(unique_id))
            return unique_ids[unique_id];
        return 0;
    }

    public bool HasUniqueID(string unique_id)
    {
        return unique_ids.ContainsKey(unique_id);
    }

    public static PlayerData Get()
    {
        return player_data;
    }
}
