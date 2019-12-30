package org.samo_lego.worldpupa;

import net.fabricmc.api.DedicatedServerModInitializer;
import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.*;
import java.util.Objects;
import java.util.Properties;

public class WorldPupa implements DedicatedServerModInitializer {
	private static final Logger LOGGER = LogManager.getLogger();

	@Override
	public void onInitializeServer() {
		try (InputStream input = new FileInputStream("./server.properties")) {
			LOGGER.info("[WorldPupa] I hope you've made a backup of your world.");
			LOGGER.info("[WorldPupa] Starting the world conversion.");
			Properties prop = new Properties();
			// load server properties file
			prop.load(input);
			String worldName = prop.getProperty("level-name");
			File nether = new File("./" + worldName + "_nether/DIM-1");
			File theEnd = new File("./" + worldName + "_the_end/DIM1");
			File dimMinusOne = new File("./" + worldName + "/DIM-1");
			File dimOne = new File("./" + worldName + "/DIM1");

			if (
					!nether.exists() || !theEnd.exists() ||
					(dimMinusOne.exists() && Objects.requireNonNull(dimMinusOne.list()).length != 0) ||
					(dimOne.exists() && Objects.requireNonNull(dimOne.list()).length != 0)
			)
				LOGGER.error("[WorldPupa] You don't have dimensions or world is already converted!");
			else {
				// Converting the nether
				if (nether.renameTo(dimMinusOne)) {
					LOGGER.info("[WorldPupa] Successfully converted the nether.");
					// Cleaning what's left behind
					FileUtils.forceDelete(nether);
				}
				else
					LOGGER.error("[WorldPupa] Error moving nether directory!");
				// Converting the End
				if (theEnd.renameTo(dimOne)) {
					LOGGER.info("[WorldPupa] Successfully converted the end.");
					FileUtils.forceDelete(theEnd);
				}
				else
					LOGGER.error("[WorldPupa] Error moving end directory!");
				LOGGER.info("[WorldPupa] That's it. Feel free to disable the mod on the next run.");
			}
		} catch (FileNotFoundException e) {
			LOGGER.error("[WorldPupa] File not found! ", e);
		} catch (IOException e) {
			LOGGER.error("[WorldPupa] An error occurred: ", e);
		}
	}
}