import { useEffect, useState } from "react";
import { snail_game_contract } from "@../../util/contractdetails";
import styles from '../styles/Home.module.css';

export default function Home() {
	const [snailDistance1, setSnailDistance1] = useState(0);
	const [snailDistance2, setSnailDistance2] = useState(0);
	const [snailDistance3, setSnailDistance3] = useState(0);

	const [snailOwner1, setSnailOwner1] = useState("None");
	const [snailOwner2, setSnailOwner2] = useState("None");
	const [snailOwner3, setSnailOwner3] = useState("None");

	const [refreshButton, setRefreshButton] = useState("Refresh");
	const [buttonDisabled, setButtonDisabled] = useState(false);

	async function refreshSnailDistance() {
		setButtonDisabled(true);
		setRefreshButton("Refreshing...");
		const result1 = await snail_game_contract.getSnail(1);
		const result2 = await snail_game_contract.getSnail(2);
		const result3 = await snail_game_contract.getSnail(3);
		//hex to decimal conversion
		setSnailDistance1(parseInt(result1[0]._hex, 16));
		setSnailDistance2(parseInt(result2[0]._hex, 16));
		setSnailDistance3(parseInt(result3[0]._hex, 16));

		setSnailOwner1(result1[1] === "0x0000000000000000000000000000000000000000" ? "Open" : result1[1]);
		setSnailOwner2(result2[1] === "0x0000000000000000000000000000000000000000" ? "Open" : result2[1]);
		setSnailOwner3(result3[1] === "0x0000000000000000000000000000000000000000" ? "Open" : result3[1]);

		console.log(snailOwner1);
		console.log(snailOwner2);
		console.log(snailOwner3);
		setTimeout(() => {
			
		}, 5000);
		setButtonDisabled(false);
		setRefreshButton("Refresh");
	}



	useEffect(() => {
		const canvas = document.getElementById('myCanvas');
		const ctx = canvas.getContext('2d');

		const snailImage1 = new Image();
		const snailImage2 = new Image();
		const snailImage3 = new Image();

		snailImage1.src = "images/snail.jpeg";
		snailImage2.src = "images/snail2.jpg";
		snailImage3.src = "images/snail3.png";

		ctx.fillStyle = "#9AF764";
		ctx.fillRect(0, 0, canvas.width, canvas.height);
		(async () => {
			await refreshSnailDistance();
		})();
		BuildStartFinishLine();
		//image on load
		ctx.fillStyle = "black";
		ctx.font = "12px Arial";
		snailImage1.onload = () => {
			ctx.drawImage(snailImage1, 10 + (snailDistance1) * 128, 50, 100, 100);
			ctx.fillText(snailOwner1.substring(0,15), 10 + (snailDistance1) * 128, 160);
		}
		snailImage2.onload = () => {
			ctx.drawImage(snailImage2, 10 + (snailDistance2) * 128, 200, 100, 100);
			ctx.fillText(snailOwner2.substring(0,15), 10 + (snailDistance2) * 128, 310);
		}
		snailImage3.onload = () => {
			ctx.drawImage(snailImage3, 10 + (snailDistance3) * 128, 350, 100, 100);
			ctx.fillText(snailOwner3.substring(0,15), 10 + (snailDistance3) * 128, 460);
		}
	}, [snailDistance1, snailDistance2, snailDistance3]);

	function BuildStartFinishLine(){
		//create black and white checkerboard at finish line
		const canvas = document.getElementById('myCanvas');
		const ctx = canvas.getContext('2d');

		//start line
		ctx.fillStyle = "red";
		ctx.fillRect(120, 0, 10, canvas.height);

		//finish line
		var heightindex = 0;
		ctx.fillStyle = "black";
		for(let i = 0; i < 20; i++){
			for(let j = 0; j < 3; j++){
				if(ctx.fillStyle === "#000000"){
					ctx.fillStyle = "white";
				}
				else{
					ctx.fillStyle = "black";
				}
				ctx.fillRect(1200 + (j * 25), heightindex, 25, 25);
			}
			heightindex += 25;
		}
	}

	return (
		<div>
			<div className={styles.buttonscontainer}>
				<button onClick={refreshSnailDistance} disabled={buttonDisabled} className={styles.refreshButton}>{refreshButton}</button>
			</div>
			<div className={styles.racetrack}>
				<canvas id="myCanvas" width="1400" height="500"></canvas>
			</div>
		</div>
	);
}
