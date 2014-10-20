import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.StreamTokenizer;
import java.util.Arrays;

class Main {


	void LIS(int[] a, int size)
	{
		int[] M = new int[size + 1];
		int[] MVals = new int[size + 1];
		int L = 1;
		M[1] = 0;
		MVals[1] =  a[0];
		
		//init logic here
		for (int i = 1; i < size; i++)
		{
			//binary search
			int index = Arrays.binarySearch(MVals, 1, L + 1, a[i]);
			
			int insertionPoint = (index + 1) * -1;

			if (insertionPoint == L + 1)
			{
				L++;
				M[L] = i;
				MVals[L] = a[i];
				
			}else{
				M[insertionPoint] = i;
				MVals[insertionPoint] = a[i];
			}
			
		}
	}
}
